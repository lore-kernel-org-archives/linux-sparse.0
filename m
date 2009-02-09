From: Christopher Li <sparse@chrisli.org>
Subject: Re: fun with declarations and definitions
Date: Sun, 8 Feb 2009 23:52:23 -0800
Message-ID: <70318cbf0902082352n32450ca2g87c847bb035baf15@mail.gmail.com>
References: <20090202073018.GB28946@ZenIV.linux.org.uk>
	 <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
	 <20090203041317.GH28946@ZenIV.linux.org.uk>
	 <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com>
	 <498B3435.8010506@knosof.co.uk>
	 <20090205202811.GO28946@ZenIV.linux.org.uk>
	 <20090205211921.GP28946@ZenIV.linux.org.uk>
	 <20090206053655.GS28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:64037 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZBIHwY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Feb 2009 02:52:24 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1693756rvb.1
        for <linux-sparse@vger.kernel.org>; Sun, 08 Feb 2009 23:52:23 -0800 (PST)
In-Reply-To: <20090206053655.GS28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Derek M Jones <derek@knosof.co.uk>, linux-sparse@vger.kernel.org

On Thu, Feb 5, 2009 at 9:36 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Feb 05, 2009 at 09:19:21PM +0000, Al Viro wrote:
>> IOW, direct_declarator() (which doubles for direct-abstract-declarator) should
>> have more than one-bit indication of which case we've got.  Right now it's
>> done by "have we passed a non-NULL ident ** to store the identifier being
>> declared"; that's not enough.  What we need is explicit 'is that a part of
>> parameter declaration' flag; then the rule turns into
>>       if (p && *p)
>>               fn = 1; /* we'd seen identifier already, can't be nested */
>>       else if match_op(next, ')')
>>               fn = 1; /* empty list can't be direct-declarator or
>>                        * direct-abstract-declarator */
>>       else
>>               fn = (in_parameter && lookup_type(next));
>
> Umm...  It's a bit more subtle (p goes NULL after the nested one is
> handled), so we need to keep track of "don't allow nested declarator from
> that point on" explicitly.  Patch follows:
>
> Subject: [PATCH] Handle nested declarators vs. parameter lists correctly
>
> Seeing a typedef name after ( means that we have a parameter-type-list
> only if we are parsing a parameter declaration or a typename; otherwise
> it might very well be a redeclaration (e.g. int (T); when T had been a
> typedef in outer scope).

The patch looks great. Applied.

Chris
