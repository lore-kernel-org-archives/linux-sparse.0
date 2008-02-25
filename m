From: Pavel Roskin <proski@gnu.org>
Subject: Re: feature-request
Date: Mon, 25 Feb 2008 09:22:49 -0500
Message-ID: <1203949369.802.22.camel@dv>
References: <20080223133945.GB10967@artemis.madism.org>
	 <1203907725.25518.17.camel@dv>  <20080225085408.GA9390@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:13667 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026AbYBYOWv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Feb 2008 09:22:51 -0500
In-Reply-To: <20080225085408.GA9390@artemis.madism.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
Cc: linux-sparse@vger.kernel.org

On Mon, 2008-02-25 at 09:54 +0100, Pierre Habouzit wrote:

> > Perhaps a simpler approach would be to turn off warnings in any files
> > included using angle brackets.
> 
>   Nope, that's not good, because I use angle brackets to #include files
> from my projects when I use internally in-tree headers that will in the
> end be public.
> 
>   I'd rather like to ask to ignore warnings for example, for file under
> /usr/include and /usr/lib/gcc/

You are right.  I think sparse should try to follow gcc in this regard.
There are three hardcoded directories in pre-process.c
(/usr/include, /usr/local/include and the gcc include directory).  Maybe
they should be considered system include directories.

-- 
Regards,
Pavel Roskin
