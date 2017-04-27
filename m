From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] fix expansion of integers to floats
Date: Thu, 27 Apr 2017 18:47:23 -0400
Message-ID: <CANeU7Qkv_23-6yQv639AS=Gp1Gdd-vE0v8V13=vVP-hbYFQR=Q@mail.gmail.com>
References: <20170327143403.62903-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36474 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161861AbdD0WrY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 27 Apr 2017 18:47:24 -0400
Received: by mail-io0-f175.google.com with SMTP id p80so39179876iop.3
        for <linux-sparse@vger.kernel.org>; Thu, 27 Apr 2017 15:47:24 -0700 (PDT)
In-Reply-To: <20170327143403.62903-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

On Mon, Mar 27, 2017 at 10:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The test wasn't using is_float_type() and thus missed
> SYM_NODE->SUM_BASETYPE::fp_type.


Looks good to me.

Chris
