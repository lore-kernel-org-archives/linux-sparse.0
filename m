From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] add __builtin functions for isinf_sign, isfinite and
 isnan
Date: Fri, 17 Nov 2017 09:13:49 +0100
Message-ID: <20171117081348.5cdzuctwi6i3ltu6@ltop.local>
References: <20171116230817.10011-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46637 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965253AbdKQINt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Nov 2017 03:13:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id z3so4681031wme.5
        for <linux-sparse@vger.kernel.org>; Fri, 17 Nov 2017 00:13:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171116230817.10011-1-logang@deltatee.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Thu, Nov 16, 2017 at 04:08:17PM -0700, Logan Gunthorpe wrote:
> These bultins are defined by in gcc since 4.4. They are also now
> used by the isinf, isfinite and isnan macros. So using them with a
> newer gcc causes 'undefined identifier' errors.
> 
> Add the builtin definitions and some validation checks for these
> functions.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

> ---
> 
> Changes since v1:
>  * Remove math.h dependancy from validation tests. As a consequnce
>    we don't test that the math functions work. (Per a request from
>    Christopher.)

It would only have tested if your <math.h> doesn't have errors.

-- Luc
