From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] Allow casting to a restricted type if
 !restricted_value
Date: Wed, 22 Feb 2017 18:29:39 +0100
Message-ID: <20170222172938.q6aiysslgzvzmnbg@macpro.local>
References: <05504e5f-16ab-276b-b53e-77f71102a154@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33703 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933023AbdBVR3o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 12:29:44 -0500
Received: by mail-wr0-f195.google.com with SMTP id s27so1241857wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 09:29:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <05504e5f-16ab-276b-b53e-77f71102a154@solarflare.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Edward Cree <ecree@solarflare.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Tue, Feb 21, 2017 at 12:22:18PM +0000, Edward Cree wrote:
> If the operand of a cast to a restricted type is an unrestricted value,
>  the cast should not produce a warning, since an equivalent implied cast
>  (e.g. in an initialiser) would not do so.
> 
> Also adds a test case (bitwise-cast.c) testing implicit and explicit
>  conversions of zero and nonzero integers to bitwise type.
> 
> Signed-off-by: Edward Cree <ecree@solarflare.com>
> ---
> v2: combined change and test case into one patch;
>     removed RFC tags.

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Tested-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
