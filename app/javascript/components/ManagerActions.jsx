import React from 'react'
import PropTypes from 'prop-types'

const RefreshIcon = () => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width="16"
    height="16"
    fill="currentColor"
    className="bi bi-arrow-clockwise"
    viewBox="0 0 16 16">
    <path
      fillRule="evenodd"
      d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"
    />
    <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z" />
  </svg>
)

const ManagerActions = ({ isManager, server, onRefresh }) => {
  return (
    <div className="d-flex justify-content-between align-items-center mt-2">
      <span>
        {isManager && (
          <>
            <a
              href={`/servers/${server.id}`}
              role="button"
              className="text-decoration-none">
              発言の集計をする
            </a>
            <small>（サーバの管理者のみが実行できます）</small>
          </>
        )}
      </span>
      <button
        className="btn rounded-pill btn-link btn-sm p-0 text-decoration-none"
        onClick={onRefresh}>
        <RefreshIcon />
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
