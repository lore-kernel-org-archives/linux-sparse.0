From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 00/13] improve constexpr handling
Date: Mon, 25 Jan 2016 22:01:07 +0100
Message-ID: <20160125210106.GB43341@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36314 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbcAYVBL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 16:01:11 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so13603215wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 13:01:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87twm1g1go.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:47:51PM +0100, Nicolai Stange wrote:
> This is the second attempt to clean up and improve sparse's handling
> of constant expressions. After I got some helpful reviews from
> Josh Triplett and Luc Van Oostenryck on my initial RFC series, I feel
> quite comfortable with this now and dropped the 'RFC' tag in favour of
> 'v2'.

Great.
 
> Quote from my initial 'RFC' cover letter regarding the structure of
> this series:
> 
>   This patch series is split into four parts:
>   - The first part deals with the refactorization of the current integer
>     constant expression handling and introduces some support for
>     recognizing arithmetic expressions. [1-5/13]
>   - The second part introduces support for recognizing address constants.
>     [6/13]
>   - The third part introduces a check for the constness of static storage
>     duration objects' initializers. [7/13]
>   - The last part stems from my tests with the kernel. It contains things
>     I missed in the first [9-10/13] and second [8,12/13] parts and
>     relaxes some of the constraints on constant expressions [11/13].
>     For the last patch [13/13], please see below. 
>   [...]
>   Although the patches of the fourth part, the fixup part, fit very well
>   into the first two categories, their associated testcases, if any,
>   depend on [7/13]. Thus, I dediced to keep the order as is.

Yes, it's fine. certainly so since you now added the -W flag.
I really consider your [13/13] as a totally separate patch
but it needs this series to see its effect.

> Quote end.
> 
> 
> The question from the initial 'RFC' series whether or not to relax the
> constexpr constraints, meaning that
> 
>   a difference of address constants may yield an integer constant
> 
> in order to make the kernel's ACPI_OFFSET macro happy, is still
> unaddressed. However, if it turns out that we actually want to do so,
> this single issue can be easily handled by some follow up patch.

Yes, indeed.


Luc
