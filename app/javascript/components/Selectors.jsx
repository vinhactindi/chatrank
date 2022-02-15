import React, { useState } from 'react'
import Select from 'react-select'
import PropTypes from 'prop-types'

const styles = {
  control: (base, { isFocused }) => ({
    ...base,
    borderColor: isFocused ? '#86b7fe' : '#6c757d',
    boxShadow: isFocused ? '0 0 0 0.25rem rgb(13 110 253 / 25%)' : 'none'
  }),
  option: (base) => ({
    ...base,
    borderBottom: '1px dotted',
  }),
}

const updatingOption = {
  id: 'update',
  name: '⚒️　更新'
}

const updatedOption = {
  id: 'updated',
  name: '✅　更新しました'
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
    fetch('/servers.json')
      .then((res) => res.json())
      .then((result) => {
        setServers([updatingOption, ...result.servers])
        setServersLoading(false)
      })
      .catch(() => {
        setServersLoading(false)
      })
  }

  const handleFocusChannelSelect = () => {
    if (
      !props.selectedServer ||
      ['update', 'updated'].includes(props.selectedServer.id)
    )
      return

    setChannelsLoading(true)
    fetch(`/servers/${props.selectedServer.id}/channels.json`)
      .then((res) => res.json())
      .then((result) => {
        setChannels([updatingOption, ...result.channels])
      })
      .finally(() => {
        setChannelsLoading(false)
      })
  }

  const handleFocusPeriodSelect = () => {
    if (
      !props.selectedServer ||
      ['update', 'updated'].includes(props.selectedServer.id)
    )
      return

    setPeriodsLoading(true)
    fetch(`/servers/${props.selectedServer.id}/periods.json`)
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

    fetch('/servers.json', {
      method: 'POST',
      headers: {
        'X-CSRF-TOKEN': csrfToken,
        'Content-Type': 'application/json'
      }
    })
      .then((res) => res.json())
      .then((result) => {
        if (result.flash) {
          props.onMessage(result.flash)
          props.onChangeServer(updatedOption)
          return
        }

        setServers([updatingOption, ...result.servers])
        props.onChangeServer(updatedOption)
      })
      .finally(() => {
        setServersLoading(false)
      })
  }

  const updateChannelsList = (serverId) => {
    setChannelsLoading(true)
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/servers/${serverId}/channels.json`, {
      method: 'POST',
      headers: {
        'X-CSRF-TOKEN': csrfToken,
        'Content-Type': 'application/json'
      }
    })
      .then((res) => res.json())
      .then((result) => {
        if (result.flash) {
          props.onMessage(result.flash)
          props.onChangeChannel(updatedOption)
          return
        }

        setChannels([updatingOption, ...result.channels])
        props.onChangeChannel(updatedOption)
      })
      .finally(() => {
        setChannelsLoading(false)
      })
  }

  const handleSelectServer = (server) => {
    if (server?.id === 'update') updateServersList()

    props.onChangeServer(server)
    props.onChangeChannel(null)
  }

  const handleSelectChannel = (channel) => {
    if (channel?.id === 'update') updateChannelsList(props.selectedServer.id)

    props.onChangeChannel(channel)
  }

  return (
    <React.Fragment>
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
            getOptionLabel={(option) => option.name}
            getOptionValue={(option) => option.id}
            value={props.selectedServer}
            onChange={handleSelectServer}
            options={servers}
            placeholder="選択..."
            onFocus={handleFocusServerSelect}
            isLoading={serversLoading}
            styles={styles}
          />
        </div>
        <div className="col px-1">
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
            getOptionLabel={(option) => option.name}
            getOptionValue={(option) => option.id}
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
            placeholder="今月"
            styles={styles}
            isClearable
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
  onChangePeriod: PropTypes.func,
  onMessage: PropTypes.func
}

export default Selectors
