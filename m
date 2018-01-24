From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Wed, 24 Jan 2018 20:19:23 +0100
Message-ID: <20180124191922.t54focjgwmls7uz7@ltop.local>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
 <20180124082814.a36sur5e7cusrleb@ltop.local>
 <bb561f3d-342c-4f6c-5309-e16aa6fdafa4@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:42479 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeAXTT1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 14:19:27 -0500
Received: by mail-wm0-f52.google.com with SMTP id r71so10516195wmd.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Jan 2018 11:19:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bb561f3d-342c-4f6c-5309-e16aa6fdafa4@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Wed, Jan 24, 2018 at 09:48:07AM -0800, Randy Dunlap wrote:
> On 01/24/2018 12:28 AM, Luc Van Oostenryck wrote:
> > On Mon, Jan 22, 2018 at 11:05:09AM -0800, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> In error(), quiet is undefined when the command:
> >>   $ ./test-suite format filename1.c foobar1
> >>
> >> is used and filename1.c does not exist. This causes a shell script error:
> >>   ./test-suite: line 147: [: : integer expression expected
> >>
> >> because $quiet is undefined in
> >>   [ "$quiet" -ne 1 ] && echo "error: $1"
> >> so the error message is lost.
> >>
> >> Just initialize quiet before any command line parsing.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > cfr: https://marc.info/?l=linux-sparse&m=151273892009415
> 
> I don't think that will fix the original problem that I posted the
> patch for.

Yes, you're right.
The original problem doesn't exist in my tree but for other reasons.

-- Luc
