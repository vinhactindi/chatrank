import React from 'react'
import PropTypes from 'prop-types'

const Leaderboard = ({ ranks }) => {
  return (
    <React.Fragment>
      <ol className="list-group list-group-numbered mt-2">
        {ranks.map((rank) => (
          <li
            key={rank.id}
            className="list-group-item d-flex justify-content-between align-items-start border-secondary">
            <div className="ms-1 me-auto">
              <span className="fw-bold">{rank.user.username}</span>
              {'#' + rank.user.discriminator}
            </div>
            <span>
              {rank.messages_count} <small>メッセージ</small>
            </span>
          </li>
        ))}
      </ol>
    </React.Fragment>
  )
}

Leaderboard.propTypes = {
  ranks: PropTypes.arrayOf(PropTypes.object),
  updating: PropTypes.bool,
  onRefresh: PropTypes.func
}

export default Leaderboard
