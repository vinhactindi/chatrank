import React from 'react'
import PropTypes from 'prop-types'

const ManagerActions = ({ isManager, server, onRefresh }) => {
  return (
    <div className="d-flex justify-content-between align-items-center mt-2">
      <span>
        {isManager && (
          <>
            管理者ので、
            <a
              href={`/servers/${server.id}`}
              role="button"
              className="text-decoration-none">
              過去統計
            </a>
            できます
          </>
        )}
      </span>
      <button
        className="btn btn-link btn-sm p-0 text-decoration-none"
        onClick={onRefresh}>
        リフレッシュ
      </button>
    </div>
  )
}

ManagerActions.propTypes = {
  server: PropTypes.object,
  isManager: PropTypes.bool,
  onRefresh: PropTypes.func
}

export default ManagerActions
