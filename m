From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] evaluate: mark evaluate_generic_selection() as static
Date: Sat, 30 May 2020 19:58:46 +0200
Message-ID: <20200530175846.65it7dkpk4shjhrk@ltop.local>
References: <37ef319f-ed1e-071d-ff4b-cb3a997fbf65@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgE3R6t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 30 May 2020 13:58:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63492C03E969
        for <linux-sparse@vger.kernel.org>; Sat, 30 May 2020 10:58:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f7so5262090ejq.6
        for <linux-sparse@vger.kernel.org>; Sat, 30 May 2020 10:58:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <37ef319f-ed1e-071d-ff4b-cb3a997fbf65@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, May 30, 2020 at 06:51:38PM +0100, Ramsay Jones wrote:
> 
> Commit c100a7ab (add support for _Generic, 2020-05-28) added the
> function evaluate_generic_selection() as an external symbol, without
> providing an external declaration in a header file. This causes
> sparse to issue a warning as part of the 'selfcheck' target.
> 
> Since this function does not (currently) need to be an external symbol,
> mark it as static.

Hmm, yes. I should taste my own dogfood and use 'make selfcheck' ...
Thanks.

-- Luc 
