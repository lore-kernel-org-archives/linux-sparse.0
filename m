From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Casting away noderef and address spaces?
Date: Mon, 22 Dec 2008 14:33:10 -0800
Message-ID: <70318cbf0812221433y62197ec7y851f00fa5775f150@mail.gmail.com>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
	 <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
	 <20081222213953.GN28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:25952 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbYLVWdL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 17:33:11 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2110043rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 14:33:10 -0800 (PST)
In-Reply-To: <20081222213953.GN28946@ZenIV.linux.org.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org

On Mon, Dec 22, 2008 at 1:39 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Works here (built from 8f208e215a531d2b32aec0428fd5eaa24ae3100b)...
>
> But yes, SYM_TYPEOF is a brittle mess, so whether that works or not
> is, er, version-dependent ;-/

Very strange. That is exactly what I have in my clean sparse git tree.
I just clone it a few minutes ago. It give me errors on your example.

On my clean tree, I need the attached patch to get it to work.

>
> I really ought to resurrect lazy-type-expressions branch...
>

Are you sure you don't have some of those bits left over on your
git tree? If you submit your lazy-type-expressions patch, I can help to
review it.

BTW, I am normally lazy enough that I am happy about just submitting
patches. On the other hand, I am tried of these sparse patches floating
around the mailing list. I can start a branch to merge the proper patches.
Maybe some thing like a development branch for sparse.
Is that some thing other people want?

Chris
