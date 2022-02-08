import React, { useEffect, useState } from 'react'
import Leaderboard from './Leaderboard'
import Selectors from './Selectors'

const Ranks = () => {
  const [selectedServer, setSelectedServer] = useState(() => {
    const saved = localStorage.getItem('server')
    const initialValue = JSON.parse(saved)
    return initialValue || null
  })

  const [selectedChannel, setSelectedChannel] = useState(() => {
    const saved = localStorage.getItem('channel')
    const initialValue = JSON.parse(saved)
    return initialValue || null
  })

  const [selectedPeriod, setSelectedPeriod] = useState(() => {
    const saved = localStorage.getItem('period')
    const initialValue = JSON.parse(saved)
    return initialValue || null
  })

  const [ranks, setRanks] = useState([])
  const [isUpdatingLeaderboard, setIsUpdatingLeaderboard] = useState(false)
  const [ranksLoading, setRanksLoading] = useState(false)

  const loadRanks = () => {
    const url = new URL('http://localhost:3000/ranks.json')

    url.searchParams.append('period', selectedPeriod.value)

    if (selectedChannel) {
      url.searchParams.append('rankable_type', 'Channel')
      url.searchParams.append('rankable_id', selectedChannel.value)
    } else if (selectedServer) {
      url.searchParams.append('rankable_type', 'Server')
      url.searchParams.append('rankable_id', selectedServer.value)
    } else return

    setRanksLoading(true)
    fetch(url)
      .then((res) => res.json())
      .then((result) => {
        if (result.updating) setIsUpdatingLeaderboard(true)
        if (result.ranks) {
          setIsUpdatingLeaderboard(false)
          setRanks(result.ranks)
        }
        setRanksLoading(false)

        localStorage.setItem('period', JSON.stringify(selectedPeriod))
        localStorage.setItem('channel', JSON.stringify(selectedChannel))
        localStorage.setItem('server', JSON.stringify(selectedServer))
      })
      .catch(() => {
        setRanksLoading(false)
      })
  }

  useEffect(() => {
    if (!selectedPeriod) return

    const updates = ['updated', 'update']
    if (
      updates.includes(selectedChannel?.value) ||
      updates.includes(selectedServer?.value)
    ) {
      setRanks([])
      return
    }

    loadRanks()
  }, [selectedServer, selectedChannel, selectedPeriod])

  return (
    <React.Fragment>
      <Selectors
        selectedServer={selectedServer}
        onChangeServer={setSelectedServer}
        selectedPeriod={selectedPeriod}
        onChangePeriod={setSelectedPeriod}
        selectedChannel={selectedChannel}
        onChangeChannel={setSelectedChannel}
      />
      <Leaderboard
        ranks={ranks}
        loading={ranksLoading}
        updating={isUpdatingLeaderboard}
        onRefresh={loadRanks}
      />
    </React.Fragment>
  )
}

export default Ranks
