import React from 'react'
import PropTypes from 'prop-types'

const ManagerActions = ({ server }) => {
  if (!server.manager) return null

  return (
    <div className="d-flex justify-content-between align-items-center mt-2">
      あなたはこのサーバーの管理者です
      {server.updating ? (
        <span>統計中</span>
      ) : (
        <a
          href={`/servers/${server.id}`}
          role="button"
          className="btn btn-link p-0 text-decoration-none">
          過去統計
        </a>
      )}
    </div>
  )
}

ManagerActions.propTypes = {
  server: PropTypes.object
}

export default ManagerActions
