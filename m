From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 5/5] ignore whole-range overlapping initializer
Date: Tue, 28 Feb 2017 00:34:57 +0800
Message-ID: <CANeU7QnMB+0-BQmrTar02p5pEtG9TL2ADzqqY3WDrRkJKW57FQ@mail.gmail.com>
References: <20170221110355.GD300@arm.com> <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
 <20170222153006.3035-6-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36931 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdB0Qm6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 11:42:58 -0500
Received: by mail-it0-f41.google.com with SMTP id 203so69059359ith.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 08:42:58 -0800 (PST)
In-Reply-To: <20170222153006.3035-6-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Will Deacon <will.deacon@arm.com>

On Wed, Feb 22, 2017 at 11:30 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> When an array is initialized, it may be convenient to first
> initialize all entries with some default value via the
> '[a ... b]' notation and then override some of these entries
> with a non-default value. Unfortunately, this, of course,
> is not compatible with the default warning flag '-Woverride-init'.

Looks good to me.


> +               if (!a && !Woverride_init_whole_range) {
> +                       // If first entry is the whole range, do not let
> +                       // any warning about it (this allow to initialize
> +                       // an array with some default value and then override
> +                       // some specific entries).

You might want to use some C style multi line comment /* ... */
Using // for multiple line is a bit strange.

Applied to sparse-next, but if you have update version I will
apply that as well.

Chris
