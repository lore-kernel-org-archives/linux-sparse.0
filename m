From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCHSET] fouled-bitwise handling
Date: Sun, 1 Oct 2006 15:09:50 +0100
Message-ID: <20061001140950.GV29920@ftp.linux.org.uk>
References: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:48812 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932164AbWJAOJs
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 10:09:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU20t-00084a-1I
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 15:09:51 +0100
Content-Disposition: inline
In-Reply-To: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

>       casting null pointer constant to non-zero address space is always OK

... gah.  That patch has nothing to do with the series, but it's probably
not worth pulling out (cast handling is seriously affected by the patches
that do belong there).  My apologies for missing it.

OTOH, the patch is trivial and obviously correct, so...
