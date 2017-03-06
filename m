From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] give a type to OP_PHISOURCE
Date: Mon, 6 Mar 2017 05:13:21 +0100
Message-ID: <20170306041321.wfejdyhupjmppwl6@macpro.local>
References: <20170303095421.39740-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qn-m=7F1OQKk+pYQzSNpx3e5AOnuQENbG7bz=1BjoQ3Qw@mail.gmail.com>
 <20170306024439.gkuv7a42oqx3or23@macpro.local>
 <CANeU7Q=1E7xR2V7Wi_K75oKwjez3H4siwYr0=-oC-hQp0cWLeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37737 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbdCFENZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 23:13:25 -0500
Received: by mail-wm0-f48.google.com with SMTP id n11so54252467wma.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 20:13:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=1E7xR2V7Wi_K75oKwjez3H4siwYr0=-oC-hQp0cWLeA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Mar 06, 2017 at 11:50:06AM +0800, Christopher Li wrote:
> On Mon, Mar 6, 2017 at 10:44 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Yes, those in the serie are the last version.
> > The other ones can be discarded (I keep uptodate the status of my
> > patches on patchwork).
> 
> So far I have been using patchworks as way to fetch patches.
> I should learn to use the status field. That is good to know.

I keep things simple and normaly just set the status to:
- 'Awaiting upstream' when you have pushed the patch on sparse-next,
- 'Superseded' when I post a newer version
And at more irregular interval I archive entries that are pushed
to the master branch.

For the CSE patch of last week, I've set its status to 'Under review'
instead of 'RFC' so that is stay visible on the web page:
	https://patchwork.kernel.org/project/linux-sparse/list/

Note: if you use the pwclient, you can script the status update
which is nice because otherwise it's a PITA to do this via the
web page when you have to do more than a few.

-- Luc
