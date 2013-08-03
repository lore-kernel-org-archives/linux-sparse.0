From: Jean Sacren <sakiwit@gmail.com>
Subject: Build setting for sparse
Date: Fri, 2 Aug 2013 22:13:43 -0600
Message-ID: <20130803041343.GA3620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:49997 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab3HCEPt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 3 Aug 2013 00:15:49 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so1346974pad.14
        for <linux-sparse@vger.kernel.org>; Fri, 02 Aug 2013 21:15:49 -0700 (PDT)
Received: from localhost ([76.8.208.182])
        by mx.google.com with ESMTPSA id xe9sm14044064pab.0.2013.08.02.21.15.47
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 21:15:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

What are the simplest build settings to be put in local.mk so that all
the output files of sparse could be located in <DIRECTORY> other than
the source directory? Thanks in advance.

-- 
Jean Sacren
