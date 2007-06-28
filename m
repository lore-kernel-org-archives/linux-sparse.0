From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 06:58:50 +0100
Message-ID: <20070628055850.GE21478@ftp.linux.org.uk>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33969 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbXF1F6v (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 01:58:51 -0400
Content-Disposition: inline
In-Reply-To: <20070628053959.30704.91680.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Jun 28, 2007 at 01:39:59AM -0400, Pavel Roskin wrote:
> Use the actual sizeof values at the compile time to describe the default
> target.  If sparse is compiled on a 64-bit system, it will default to a
> 64-bit system now.
> 
> To force 32-bit operation on 64-bit systems, recognize -m32.  Reject
> machine options other than -m32 and -m64.

NAK.  That makes life very painful for cross-builds.
