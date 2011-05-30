From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: "advancing past deep designator" warnings
Date: Mon, 30 May 2011 09:45:32 -0700
Message-ID: <20110530094532.5a4dc8c4.rdunlap@xenotime.net>
References: <20110529145712.eefa4d52.rdunlap@xenotime.net>
	<20110530062141.GH3099@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:57925 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756630Ab1E3Qpf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 May 2011 12:45:35 -0400
In-Reply-To: <20110530062141.GH3099@shale.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Mon, 30 May 2011 09:21:41 +0300 Dan Carpenter wrote:

> On Sun, May 29, 2011 at 02:57:12PM -0700, Randy Dunlap wrote:
> > Hi,
> > 
> > Can you give me an idea about what this warning means and what to do about it?
> > Thanks.
> >
> 
> It means that you have an array declared like:
> 	int x[] = {
> 		[4] = 5,  <-- designator.
> 		6         <-- advance one step.
> 	};
> 
> GCC handles these correctly, so I don't think we'd want to change
> anything in the kernel because of them.

Hi Dan,
Thanks for the explanation.  I'll just ignore these warnings.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
