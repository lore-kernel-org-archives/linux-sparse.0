From: Josh Boyer <jwboyer@jdub.homelinux.org>
Subject: Re: Official releases?
Date: Tue, 31 Oct 2006 12:19:21 -0600
Message-ID: <1162318761.3785.3.camel@zod.rchland.ibm.com>
References: <1162307025.11613.1.camel@zod.rchland.ibm.com>
	 <20061031170824.GC23354@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 67-41-71-127.roch.qwest.net ([67.41.71.127]:5800 "EHLO
	jdub.homelinux.org") by vger.kernel.org with ESMTP id S1423762AbWJaSUJ
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 Oct 2006 13:20:09 -0500
In-Reply-To: <20061031170824.GC23354@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Tue, 2006-10-31 at 12:08 -0500, Dave Jones wrote:
> On Tue, Oct 31, 2006 at 09:03:45AM -0600, Josh Boyer wrote:
>  > Howdy,
>  > 
>  > I'm just curious if anyone is ever really going to do an "official"
>  > release of sparse.  We've got daily snapshots provided by Dave Jones,
>  > and git of course, but will an official release tarball with shiny
>  > version numbers and everything be created?
>  > 
>  > The only reason I ask is because it makes packaging sparse a bit easier
>  > to some degree.
> 
> Well, all you need from a version number is a monotonically increasing
> number right?  You could munge the daily snapshot dates into same.

Yes, but you don't keep them all laying around forever.  You keep about
a week's worth right?

So if one were to package say sparse-2006-10-25.tar.gz, it'll disappear
in a week.  Makes it hard to verify those against the upstream tarball
when the tarball no longer exists :).

> It's not as 'pretty' as a real version number, but it works with
> minimal effort on behalf of Linus.

Yeah, I know.  It's not a big deal.  I was just curious if something
like an official release was ever even planned or not.

josh
