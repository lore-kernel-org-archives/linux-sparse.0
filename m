From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 24 Feb 2016 17:45:22 +0800
Message-ID: <CANeU7QmexP2=N49uP3fgWQDvqaFSO_APr+DD6C2_exBSTfyW+A@mail.gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
	<87y4ahun1h.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:33204 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbcBXJpX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Feb 2016 04:45:23 -0500
Received: by mail-io0-f174.google.com with SMTP id z135so28206158iof.0
        for <linux-sparse@vger.kernel.org>; Wed, 24 Feb 2016 01:45:23 -0800 (PST)
In-Reply-To: <87y4ahun1h.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sorry for the late reply.

I take a look of your V3 patches.

May I ask a few questions regarding the constant expression.

+       CONSTEXPR_FLAG_INT_CONST = (1 << 0),
+       CONSTEXPR_FLAG_FP_CONST = (1 << 1),
+       CONSTEXPR_FLAG_ENUM_CONST = (1 << 2),
+       CONSTEXPR_FLAG_CHAR_CONST = (1 << 3),

Can I say each of the above constant type are elusive to each other?
e.g. the floating point constant can not be a integer constant at the
same time.

+
+       /*
+        * A constant expression in the sense of [6.6]:
+        * - integer constant expression [6.6(6)]
+        */
+       CONSTEXPR_FLAG_INT_CONST_EXPR = (1 << 4),

Can we express the const expression in terms of above constant flags?
Each expression will have a ctype associate with it. It can be one of the
int/fp/enum/char type.

e.g. "1.0 + 1" is a floating type expression according to the C rules.

In other words, it seems to me that the constant expression
should have a deterministic ctype. We should be able to reuse the above
constant flag without adding a new one. If not, please give some example
to help me understand the issue.

I am not suggesting to change your patches at this stage. It just
help me understand your patch.

Thanks

Chris



On Fri, Feb 19, 2016 at 4:22 PM, Nicolai Stange <nicstange@gmail.com> wrote:
> Nicolai Stange <nicstange@gmail.com> writes:
>
>> Here comes the greatly enhanced v3 of this series.
>
> Just a gently push to get some reviews on this...
>
