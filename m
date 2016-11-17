From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] cleanup: remove evaluate_arguments()'s unused argument
Date: Fri, 18 Nov 2016 00:27:40 +0800
Message-ID: <CANeU7Qk++Z=4dBRFcOZyiF=mPBF2F17kkHGGaUH7-HR5xYdZsw@mail.gmail.com>
References: <20161102171623.17883-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=SJXw41JNRLJtKGOCgEPSnWhKZyRfMicS=suJwH73LNg@mail.gmail.com> <20161117111336.GA499@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38109 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933981AbcKQR2h (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:28:37 -0500
Received: by mail-it0-f43.google.com with SMTP id j191so64552236ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:28:37 -0800 (PST)
In-Reply-To: <20161117111336.GA499@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 17, 2016 at 7:13 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

>
> Not much important to me, but said above, it's confusing: two args,
> one called 'f', the other one 'fn' and one of them is unused ...

Points taken.

>
>> Or maybe change it to "node" instead of "f", will that be better to understand?
> Not much I think, 'node' has even less meaning to me than 'f'or 'fn'.
> Better then to focus on the (potential) purpose of this arg.
> If it's for the position, maybe pass only sym->pos.

OK. I will just apply the patch. We can always add the argument back
if there is a real need for it.

Chris
