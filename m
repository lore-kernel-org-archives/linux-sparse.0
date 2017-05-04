From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: bit-field notation and k&r function syntax
Date: Thu, 4 May 2017 04:14:35 +0200
Message-ID: <20170504021406.abel7cm25x6fazkh@ltop.local>
References: <1231012108.4484627.1493830970281.JavaMail.zimbra@redhat.com>
 <571546431.4485670.1493831412428.JavaMail.zimbra@redhat.com>
 <20170503230721.vb4aunmpaa2xxaf2@desk.local>
 <CANeU7Qn+R5auoxi=-==W+uExRfE7wRc7pfK-5OcENVEaB1-9Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35993 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbdEDCOj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 22:14:39 -0400
Received: by mail-wr0-f181.google.com with SMTP id l50so280035wrc.3
        for <linux-sparse@vger.kernel.org>; Wed, 03 May 2017 19:14:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn+R5auoxi=-==W+uExRfE7wRc7pfK-5OcENVEaB1-9Hw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 03, 2017 at 09:50:14PM -0400, Christopher Li wrote:
> On Wed, May 3, 2017 at 7:07 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > What's sparse use 'declaration_list()' for is not what correspond
> > to the standard's 'declaration-list' but is indeed for something
> > that should be reserved to structs.
> 
> I think declaration_list() can add one argument "is_struct" to
> indicate parse for struct or not.
> Only in struct mode we do the ":" and handle_bitfield() thing.
> There are only two caller of declaration_list() so that should fix it.

Yes, but there are a few details we need to look at.
For example, this should be supported (GCC does)
	int foo(a)
		register int a;
	{
		return a;
	}

But this we should warn on this
	struct s {
		register int a;
	};
And currently, we don't.

-- Luc
