/*
 * Copyright (C) 2008 TopCoder Inc., All Rights Reserved.
 */
package com.topcoder.clients.dao.ejb3;

import javax.ejb.Local;

import com.topcoder.clients.dao.CompanyDAO;

/**
 * <p>
 * This interface represents the CompanyDAOLocal local interface of the session
 * bean.
 * </p>
 * <p>
 * See base interface for other available operations.
 * </p>
 * <p>
 * Defines a static String variable containing the JNDI name of the local
 * interface.
 * </p>
 * <p>
 * <strong>THREAD SAFETY:</strong> Implementations of this interface should be
 * thread safe.
 * </p>
 *
 * @author Mafy, TCSDEVELOPER
 * @version 1.0
 */
@Local
public interface CompanyDAOLocal extends CompanyDAO {
    /**
     * <p>
     * This static final String field represents the 'JNDI_NAME' identifier of
     * the CompanyDAOLocal interface. Represents the JNDI name of this local
     * interface.
     * </p>
     * <p>
     * It is initialized to a default value: CompanyDAO.BEAN_NAME + "/local"
     * String during runtime.
     * </p>
     */
    public static final String JNDI_NAME = CompanyDAO.BEAN_NAME + "/local";
}