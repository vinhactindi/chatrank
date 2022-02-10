import React from 'react'
import PropTypes from 'prop-types'

const Flash = ({ title, type, message }) => {
  return (
    <div className={`alert alert-${type} mt-2`} role="alert">
      <h4 className="alert-heading">{title}</h4>
      <p>{message}</p>
    </div>
  )
}

Flash.propTypes = {
  title: PropTypes.string,
  type: PropTypes.string,
  message: PropTypes.string
}

const FlashMessages = ({ flash }) => {
  if (!flash) return null

  return (
    <>
      {flash.error && (
        <Flash title="ヤバい!!!" type="danger" message={flash.error} />
      )}
      {flash.alert && (
        <Flash title="おっとっと~" type="warning" message={flash.alert} />
      )}
      {flash.notice && (
        <Flash title="知らせ" type="info" message={flash.notice} />
      )}
    </>
  )
}

FlashMessages.propTypes = {
  flash: PropTypes.object
}

export default FlashMessages
