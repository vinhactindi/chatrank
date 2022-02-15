import React from 'react'
import PropTypes from 'prop-types'

const ManagerActions = ({ isManager, server }) => {
  if (!isManager) return null

  return (
    <div className="d-flex justify-content-between align-items-center mt-2">
      あなたはこのサーバーの管理者です
      <a
        href={`/servers/${server.id}`}
        role="button"
        className="btn btn-link p-0 text-decoration-none">
        過去統計
      </a>
    </div>
  )
}

ManagerActions.propTypes = {
  server: PropTypes.object,
  isManager: PropTypes.bool
}

export default ManagerActions
