From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] compile-i386: fix use-after-free in func_cleanup()
Date: Mon, 4 Jun 2012 14:01:50 +0300
Message-ID: <CAOJsxLE_QeiKpXqy=xz1E+Beg+MCu9yJf=LYMb_iTWn1UEcNRQ@mail.gmail.com>
References: <1338567720-23595-1-git-send-email-xi.wang@gmail.com>
	<CANeU7Qm9Lo320TmkMzh6BKVC4Uwz6Pz6btuNxmW3fJH7zMMYcg@mail.gmail.com>
	<CAFtxgO7dwKEb8Fc153_jzBJira6uFrBYTd_1e4hF0q+yHc8aJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:55561 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2FDLBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2012 07:01:51 -0400
Received: by gglu4 with SMTP id u4so2868568ggl.19
        for <linux-sparse@vger.kernel.org>; Mon, 04 Jun 2012 04:01:51 -0700 (PDT)
In-Reply-To: <CAFtxgO7dwKEb8Fc153_jzBJira6uFrBYTd_1e4hF0q+yHc8aJw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christopher Li <sparse@chrisli.org>, Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org

On Mon, Jun 4, 2012 at 12:42 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On Fri, Jun 1, 2012 at 9:55 PM, Christopher Li <sparse@chrisli.org> w=
rote:
>> On Fri, Jun 1, 2012 at 9:22 AM, Xi Wang <xi.wang@gmail.com> wrote:
>>> compile-i386 sometimes crashes due a use-after-free error. =A0Since
>>> f->pseudo_list is freed first, which invalidates some atom->op* in
>>> f->atom_list. =A0Further checks like `atom->op1->flags & STOR_WANTS=
_FREE'
>>> will read garbage, which may lead to a double free.
>>>
>>> This patch switches the cleanup order and frees f->atom_list first.
>>> Those marked as STOR_WANTS_FREE won't appear in f->pseudo_list.
>>
>> Seems make sense. I will apply if Jeff don't have any objections.
>
> If the patch makes sense, go for it. =A0I'm on vacation in France unt=
il
> June 8, the original patch is not in my inbox, and I do not have
> readily available Internet connectivity besides... :)

Looks good to me.

Reviewed-by: Pekka Enberg <penberg@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
