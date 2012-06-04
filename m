From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] compile-i386: fix use-after-free in func_cleanup()
Date: Mon, 4 Jun 2012 11:42:12 +0200
Message-ID: <CAFtxgO7dwKEb8Fc153_jzBJira6uFrBYTd_1e4hF0q+yHc8aJw@mail.gmail.com>
References: <1338567720-23595-1-git-send-email-xi.wang@gmail.com>
	<CANeU7Qm9Lo320TmkMzh6BKVC4Uwz6Pz6btuNxmW3fJH7zMMYcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47421 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619Ab2FDJmO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2012 05:42:14 -0400
Received: by eeit10 with SMTP id t10so1446346eei.19
        for <linux-sparse@vger.kernel.org>; Mon, 04 Jun 2012 02:42:13 -0700 (PDT)
In-Reply-To: <CANeU7Qm9Lo320TmkMzh6BKVC4Uwz6Pz6btuNxmW3fJH7zMMYcg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org

On Fri, Jun 1, 2012 at 9:55 PM, Christopher Li <sparse@chrisli.org> wro=
te:
> On Fri, Jun 1, 2012 at 9:22 AM, Xi Wang <xi.wang@gmail.com> wrote:
>> compile-i386 sometimes crashes due a use-after-free error. =C2=A0Sin=
ce
>> f->pseudo_list is freed first, which invalidates some atom->op* in
>> f->atom_list. =C2=A0Further checks like `atom->op1->flags & STOR_WAN=
TS_FREE'
>> will read garbage, which may lead to a double free.
>>
>> This patch switches the cleanup order and frees f->atom_list first.
>> Those marked as STOR_WANTS_FREE won't appear in f->pseudo_list.
>
> Seems make sense. I will apply if Jeff don't have any objections.

If the patch makes sense, go for it.  I'm on vacation in France until
June 8, the original patch is not in my inbox, and I do not have
readily available Internet connectivity besides... :)
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
