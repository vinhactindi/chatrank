import React, { useEffect, useState } from 'react'
import FlashMessages from './FlashMessages'
import Leaderboard from './Leaderboard'
import LoadingBar from './LoadingBar'
import ManagerActions from './ManagerActions'
import Selectors from './Selectors'
import PropTypes from 'prop-types'

const thisMonth = new Date().toISOString().slice(0, 7)

const Ranks = ({ lastSeenServer }) => {
  const [selectedServer, setSelectedServer] = useState(() => {
    if (!lastSeenServer) return null

    return lastSeenServer
  })

  const [selectedChannel, setSelectedChannel] = useState(null)

  const [selectedPeriod, setSelectedPeriod] = useState(null)

  const [ranks, setRanks] = useState([])
  const [ranksLoading, setRanksLoading] = useState(false)
  const [isManager, setIsManager] = useState(false)

  const [flash, setFlash] = useState(null)

  const loadRanks = () => {
    const url = new URL(
      `${window.location.protocol}//${window.location.hostname}${
        window.location.port && `:${window.location.port}`
      }/ranks.json`
    )

    url.searchParams.append(
      'period',
      selectedPeriod ? selectedPeriod.value : thisMonth
    )

    if (selectedChannel) {
      url.searchParams.append('rankable_type', 'Channel')
      url.searchParams.append('rankable_id', selectedChannel.id)
    } else if (selectedServer) {
      url.searchParams.append('rankable_type', 'Server')
      url.searchParams.append('rankable_id', selectedServer.id)
    } else return

    setRanksLoading(true)
    fetch(url)
      .then((res) => res.json())
      .then((result) => {
        if (result.flash) setFlash(result.flash)
        if (result.ranks) setRanks(result.ranks)
        if (result.manager) setIsManager(result.manager)
        setRanksLoading(false)

        localStorage.setItem('period', JSON.stringify(selectedPeriod))
        localStorage.setItem('channel', JSON.stringify(selectedChannel))
        localStorage.setItem('server', JSON.stringify(selectedServer))
      })
      .finally(() => {
        setRanksLoading(false)
      })
  }

  useEffect(() => {
    setRanks([])
    setIsManager(false)

    const updates = ['updated', 'update']
    if (
      updates.includes(selectedChannel?.id) ||
      updates.includes(selectedServer?.id)
    ) {
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
        onMessage={setFlash}
      />
      <LoadingBar isLoading={ranksLoading} />
      <ManagerActions
        server={selectedServer}
        isManager={isManager}
        onRefresh={loadRanks}
      />
      <FlashMessages flash={flash} />
      <Leaderboard ranks={ranks} />
    </React.Fragment>
  )
}

Ranks.propTypes = {
  lastSeenServer: PropTypes.object
}

export default Ranks
