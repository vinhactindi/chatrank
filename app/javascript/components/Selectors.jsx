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

const updatingOption = {
  value: 'update',
  label: '⚒️　更新'
}

const updatedOption = {
  value: 'updated',
  label: '✅　更新しました'
}

const Selectors = (props) => {
  const [servers, setServers] = useState([])
  const [serversLoading, setServersLoading] = useState(false)

  const [channels, setChannels] = useState([])
  const [channelsLoading, setChannelsLoading] = useState(false)

  const [periods, setPeriods] = useState([])
  const [periodsLoading, setPeriodsLoading] = useState(false)

  const [alert, setAlert] = useState(null)

  const handleFocusServerSelect = () => {
    setServersLoading(true)
    fetch('http://localhost:3000/servers.json')
      .then((res) => res.json())
      .then((result) => {
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
    if (
      !props.selectedServer ||
      ['update', 'updated'].includes(props.selectedServer.value)
    )
      return

    setChannelsLoading(true)
    fetch(
      `http://localhost:3000/servers/${props.selectedServer.value}/channels.json`
    )
      .then((res) => res.json())
      .then((result) => {
        const channels = result.channels.map((s) => ({
          value: s.id,
          label: s.name
        }))
        setChannels([updatingOption, ...channels])
      })
      .finally(() => {
        setChannelsLoading(false)
      })
  }

  const handleFocusPeriodSelect = () => {
    if (
      !props.selectedServer ||
      ['update', 'updated'].includes(props.selectedServer.value)
    )
      return

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
      })
      .finally(() => {
        setPeriodsLoading(false)
      })
  }

  const updateServersList = () => {
    setServersLoading(true)
    setChannels([])
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch('http://localhost:3000/servers.json', {
      method: 'POST',
      headers: {
        'X-CSRF-TOKEN': csrfToken,
        'Content-Type': 'application/json'
      }
    })
      .then((res) => res.json())
      .then((result) => {
        if (result.alert) {
          setAlert(result.alert)
          props.onChangeServer(null)
          return
        }

        const servers = result.servers.map((s) => ({
          value: s.id,
          label: s.name
        }))
        setServers([updatingOption, ...servers])
        props.onChangeServer(updatedOption)
      })
      .finally(() => {
        setServersLoading(false)
      })
  }

  const updateChannelsList = (serverId) => {
    setChannelsLoading(true)
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`http://localhost:3000/servers/${serverId}/channels.json`, {
      method: 'POST',
      headers: {
        'X-CSRF-TOKEN': csrfToken,
        'Content-Type': 'application/json'
      }
    })
      .then((res) => res.json())
      .then((result) => {
        if (result.alert) {
          setAlert(result.alert)
          props.onChangeChannel(null)
          return
        }

        const channels = result.channels.map((s) => ({
          value: s.id,
          label: s.name
        }))
        setChannels([updatingOption, ...channels])
        props.onChangeChannel(updatedOption)
      })
      .finally(() => {
        setChannelsLoading(false)
      })
  }

  const handleSelectServer = (server) => {
    setAlert(null)
    if (server?.value === 'update') updateServersList()

    props.onChangeServer(server)
    props.onChangeChannel(null)
  }

  const handleSelectChannel = (channel) => {
    setAlert(null)
    if (channel?.value === 'update')
      updateChannelsList(props.selectedServer.value)

    props.onChangeChannel(channel)
  }

  return (
    <React.Fragment>
      {alert && (
        <div className={`alert alert-${alert.type} alert-dismissible`}>
          {alert.message}
          <button
            type="button"
            className="btn-close"
            onClick={() => setAlert(null)}></button>
        </div>
      )}
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
            value={props.selectedServer}
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
            onChange={handleSelectChannel}
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
            value={props.selectedPeriod}
            onChange={props.onChangePeriod}
            options={periods}
            isLoading={periodsLoading}
            onFocus={handleFocusPeriodSelect}
            placeholder="選択..."
            styles={styles}
          />
        </div>
      </div>
    </React.Fragment>
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
