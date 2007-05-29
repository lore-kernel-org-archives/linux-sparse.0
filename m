From: Dan Sheridan <djs@postman.org.uk>
Subject: Re: [PATCH 0/2] Improved flow graphs
Date: Tue, 29 May 2007 17:05:10 +0100
Message-ID: <1180454712.5068.49.camel@localhost.localdomain>
References: <1179310281.31308.54.camel@localhost.localdomain>
	 <46536AA6.20604@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from tuschin.blackcatnetworks.co.uk ([193.201.200.34]:45283 "EHLO
	tuschin.blackcatnetworks.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759125AbXE2QFP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 May 2007 12:05:15 -0400
In-Reply-To: <46536AA6.20604@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Tue, 2007-05-22 at 15:11 -0700, Josh Triplett wrote:
> Dan Sheridan wrote:
> > These two patches are the first of several implementing improved graph
> > generation for Sparse.
> 
> Very nice work.  I've applied both patches in this series.

Thanks.

> I noticed one minor issue: gvpr/return-paths seems to turn some internal
> edges in functions into dotted-line return paths.

I think you are talking about the edges which connect call sites to
return sites. These are needed to keep the layout of the graph sane, but
could be made invisible. It would at least help if they looked different
to the return edges.

> Also, unprocessed graphs have now become far more messy; for instance,
> graphing validation/context.c generates numerous edges to a() and r().  Any
> way you could prevent these edges from crossing other subgraphs? 

Probably not. There's a lot of tweaking possible with weights, which
I'll experiment with a bit, but your suggestion of separate a() and r()
nodes might be simpler. Should be very easy to obtain with a gvpr
script.

	Dan.
