From: Christopher Li <sparse@chrisli.org>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Wed, 19 Jul 2017 14:16:54 -0700
Message-ID: <CANeU7Q=Vt-yJ-7TKzxb2CxanZREqOJS-kGOU-2FEJTbjeT5_-A@mail.gmail.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
 <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
 <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com>
 <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com> <CAExDi1Quxc_ZfmdW2-kY=Q312Dnbi_7OsRX85_uGrHWTk1vtpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36818 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754253AbdGSVQz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 17:16:55 -0400
Received: by mail-pg0-f51.google.com with SMTP id 125so5303035pgi.3
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 14:16:55 -0700 (PDT)
In-Reply-To: <CAExDi1Quxc_ZfmdW2-kY=Q312Dnbi_7OsRX85_uGrHWTk1vtpw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Michael Stefaniuc <mstefani@mykolab.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 4:43 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I'm not yet fully back but I'll be able to look at it later, probably
> tomorrow (it's already evening here).

That is fine. How about we temporary disable that in the 0.5.1 release.
Re-enable it with some proper fix of the phi domination problem. e.g.
0.5.2.

Right now I feel a little bit uncomfortable with 11b1a83b. Already two bugs
trigger in the field. The previous fix d7985338 is not a proper fix any way.
I think the right thing to do is just release 0.5.1 with 11b1a83b disabled.
Turn on 11b1a83b in sparse-next and do more fixing there. Release
0.5.2 when it settle down with other new merges.

Chris
