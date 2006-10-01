From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCHSET] fouled-bitwise handling
Date: Sun, 1 Oct 2006 18:29:11 +0100
Message-ID: <20061001172911.GY29920@ftp.linux.org.uk>
References: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk> <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org> <Pine.LNX.4.64.0610010934590.3952@g5.osdl.org> <20061001172253.GX29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:25550 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932088AbWJAR3M
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 13:29:12 -0400
Content-Disposition: inline
In-Reply-To: <20061001172253.GX29920@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

PS: "fouled(le16)" is exactly "int, and if you narrow it to 16bit, it'd
better be le16".  We could separate that from type information, but hey,
if we want to carry reference to some type + indication that we do have
that reference + int as type, we might as well introduce a type node
saying "I'm int, might be base_type".  Which is exactly what I've done...
