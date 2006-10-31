From: Dave Jones <davej@redhat.com>
Subject: Re: Official releases?
Date: Tue, 31 Oct 2006 12:08:24 -0500
Message-ID: <20061031170824.GC23354@redhat.com>
References: <1162307025.11613.1.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423715AbWJaR5g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 Oct 2006 12:57:36 -0500
Content-Disposition: inline
In-Reply-To: <1162307025.11613.1.camel@zod.rchland.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Oct 31, 2006 at 09:03:45AM -0600, Josh Boyer wrote:
 > Howdy,
 > 
 > I'm just curious if anyone is ever really going to do an "official"
 > release of sparse.  We've got daily snapshots provided by Dave Jones,
 > and git of course, but will an official release tarball with shiny
 > version numbers and everything be created?
 > 
 > The only reason I ask is because it makes packaging sparse a bit easier
 > to some degree.

Well, all you need from a version number is a monotonically increasing
number right?  You could munge the daily snapshot dates into same.
It's not as 'pretty' as a real version number, but it works with
minimal effort on behalf of Linus.

	Dave

-- 
http://www.codemonkey.org.uk
