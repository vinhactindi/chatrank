import React, { useState } from 'react'
import Select from 'react-select'
import PropTypes from 'prop-types'

const styles = {
  control: (base, { isFocused }) => ({
    ...base,
    borderColor: isFocused ? '#86b7fe' : '#6c757d',
    boxShadow: isFocused ? '0 0 0 0.25rem rgb(13 110 253 / 25%)' : 'none'
  })
}

const Selectors = (props) => {
  const [servers, setServers] = useState([])
  const [serversLoading, setServersLoading] = useState(false)

  const [channels, setChannels] = useState([])
  const [channelsLoading, setChannelsLoading] = useState(false)

  const [periods, setPeriods] = useState([])
  const [periodsLoading, setPeriodsLoading] = useState(false)

  const handleFocusServerSelect = () => {
    setServersLoading(true)
    fetch('http://localhost:3000/servers.json')
      .then((res) => res.json())
      .then((result) => {
        const updatingOption = {
          value: null,
          label: '⚒️　更新する'
        }
        const servers = result.servers.map((s) => ({
          value: s.id,
          label: s.name
        }))
        setServers([updatingOption, ...servers])
        setServersLoading(false)
      })
      .catch(() => {
        setServersLoading(false)
      })
  }

  const handleFocusChannelSelect = () => {
    if (!props.selectedServer) return

    setChannelsLoading(true)
    fetch(
      `http://localhost:3000/servers/${props.selectedServer.value}/channels.json`
    )
      .then((res) => res.json())
      .then((result) => {
        const updatingOption = {
          value: null,
          label: '⚒️　更新する'
        }
        const channels = result.channels.map((s) => ({
          value: s.id,
          label: s.name
        }))
        setChannels([updatingOption, ...channels])
        setChannelsLoading(false)
      })
      .catch(() => {
        setChannelsLoading(false)
      })
  }

  const handleFocusPeriodSelect = () => {
    if (!props.selectedServer) return

    setPeriodsLoading(true)
    fetch(
      `http://localhost:3000/servers/${props.selectedServer.value}/periods.json`
    )
      .then((res) => res.json())
      .then((result) => {
        const periods = result.periods.map((s) => ({
          value: s,
          label: s
        }))
        setPeriods(periods)
        setPeriodsLoading(false)
      })
      .catch(() => {
        setPeriodsLoading(false)
      })
  }

  const handleSelectServer = (server) => {
    props.onChangeServer(server)
    props.onChangeChannel(null)
  }

  return (
    <div className="row">
      <div className="col-5 pe-1">
        <label id="server-label" htmlFor="server-input">
          サーバー
        </label>
        <Select
          components={{
            DropdownIndicator: () => null,
            IndicatorSeparator: () => null
          }}
          className="mb-2"
          aria-labelledby="server-label"
          inputId="server-input"
          defaultValue={props.selectedServer}
          onChange={handleSelectServer}
          options={servers}
          placeholder="選択..."
          onFocus={handleFocusServerSelect}
          isLoading={serversLoading}
          styles={styles}
        />
      </div>
      <div className="col-4 px-1">
        <label id="channel-label" htmlFor="channel-input">
          チャンネル
        </label>
        <Select
          components={{
            DropdownIndicator: () => null,
            IndicatorSeparator: () => null
          }}
          className="mb-2"
          aria-labelledby="channel-label"
          inputId="channel-input"
          value={props.selectedChannel}
          onChange={props.onChangeChannel}
          options={channels}
          onFocus={handleFocusChannelSelect}
          isLoading={channelsLoading}
          placeholder="全て"
          styles={styles}
          isClearable
        />
      </div>
      <div className="col ps-1">
        <label id="period-label" htmlFor="period-input">
          期間
        </label>
        <Select
          components={{
            DropdownIndicator: () => null,
            IndicatorSeparator: () => null
          }}
          aria-labelledby="period-label"
          inputId="period-input"
          defaultValue={props.selectedPeriod}
          onChange={props.onChangePeriod}
          options={periods}
          isLoading={periodsLoading}
          onFocus={handleFocusPeriodSelect}
          placeholder="選択..."
          styles={styles}
        />
      </div>
    </div>
  )
}

Selectors.propTypes = {
  selectedServer: PropTypes.object,
  selectedChannel: PropTypes.object,
  selectedPeriod: PropTypes.object,
  onChangeServer: PropTypes.func,
  onChangeChannel: PropTypes.func,
  onChangePeriod: PropTypes.func
}

export default Selectors
