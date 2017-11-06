From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 00/36] Makefile reorganization
Date: Mon, 6 Nov 2017 06:50:51 +0100
Message-ID: <20171106055049.t5ao5t2yy72uerzt@ltop.local>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:47203 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdKFFu5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 00:50:57 -0500
Received: by mail-wm0-f47.google.com with SMTP id r196so11308225wmf.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 21:50:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>

I've updated the series witht the feedback I received yesterday.

The changes since v1 are:
*) fold the two patches concerning the removal of shared lib support
*) remove the patch using git-clean for 'make clean'

The updated series is available for review & testing at:
    git://github.com/lucvoo/sparse.git make-cleanup-v2

Thanks for the reviewers.

-- Luc Van Oostenryck
