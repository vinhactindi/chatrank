import React from 'react'
import PropTypes from 'prop-types'

const LoadingBar = ({ isLoading }) => {
  return (
    <div className="loader">
      {isLoading && <div className="loaderBar"></div>}
    </div>
  )
}

LoadingBar.propTypes = {
  isLoading: PropTypes.bool
}

export default LoadingBar
