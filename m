From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 07:33:44 +0000
Message-ID: <20070322073344.GU4095@ftp.linux.org.uk>
References: <20070322063600.GD15364@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37953 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030201AbXCVHdp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 03:33:45 -0400
Content-Disposition: inline
In-Reply-To: <20070322063600.GD15364@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Mar 22, 2007 at 02:36:00AM -0400, Dave Jones wrote:

> Is this something new, or am I the first person dumb enough to try and
> run sparse on non-x86 ?

Segfault is new (which version?); the fscking mess in altivec is not, but
it (a) doesn't depend on host sparse is ran on; (b) shouldn't lead to
segfaults.  Altivec extensions are undocumented and fortunately used only
in one place in the tree.  You should get sparse errors, but it shouldn't
die on those.
