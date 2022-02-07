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
  const [ranksLoading, setRanksLoading] = useState(false)

  useEffect(() => {
    if (!selectedPeriod) return

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
        setRanks(result.ranks)
        setRanksLoading(false)

        localStorage.setItem('period', JSON.stringify(selectedPeriod))
        localStorage.setItem('channel', JSON.stringify(selectedChannel))
        localStorage.setItem('server', JSON.stringify(selectedServer))
      })
      .catch(() => {
        setRanksLoading(false)
      })
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
      <Leaderboard ranks={ranks} loading={ranksLoading} />
    </React.Fragment>
  )
}

export default Ranks
