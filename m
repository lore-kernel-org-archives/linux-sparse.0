From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 15:10:51 -0700
Message-ID: <20070322221050.GC22151@chrisli.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322171118.GL15364@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:61436 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbXCVWtE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 18:49:04 -0400
Content-Disposition: inline
In-Reply-To: <20070322171118.GL15364@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Thu, Mar 22, 2007 at 01:11:18PM -0400, Dave Jones wrote:
> So the good news is that this only seems to affect 0.2
> Current git doesn't segfault, but still emits lots of spew.
> 
> 	Dave
> 
> /usr/lib/gcc/powerpc64-linux/4.0.1/include/altivec.h:36:2: error: Use the "-maltivec" flag to enable PowerPC AltiVec support
> drivers/md/raid6altivec1.c:41:16: error: Expected ; at end of declaration
> drivers/md/raid6altivec1.c:41:16: error: got signed

The spew is cause by the vector extension which sparse know nothing about.
It is kind of expected.

I found a few place the kernel use "vector" as declarator. This introduce
ambiguity in expression:

(vector char) { x, x }

We look at 'vector', we can't decide it is a type or node yet. Because 'vector'
can be use as symbol. We have to look at the next token to decide if this is
cast expression or not.

Do we want to support vector in sparse?

Chris
