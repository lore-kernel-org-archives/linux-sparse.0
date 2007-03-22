From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 16:02:39 +0000
Message-ID: <20070322160238.GY4095@ftp.linux.org.uk>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322155651.GG15364@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45222 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933781AbXCVQCk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 12:02:40 -0400
Content-Disposition: inline
In-Reply-To: <20070322155651.GG15364@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Mar 22, 2007 at 11:56:51AM -0400, Dave Jones wrote:
> On Thu, Mar 22, 2007 at 07:33:44AM +0000, Al Viro wrote:
>  > On Thu, Mar 22, 2007 at 02:36:00AM -0400, Dave Jones wrote:
>  > 
>  > > Is this something new, or am I the first person dumb enough to try and
>  > > run sparse on non-x86 ?
>  > 
>  > Segfault is new (which version?);
> 
> 0.2

Could you run

make C=2 V=1 drivers/md/raid6altivec1.o

pick sparse invocation out of that and mail it *and* its output with -E
added to command line?  IOW, flags and preprocessed-by-sparse input...
