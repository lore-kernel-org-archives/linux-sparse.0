From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Tue, 14 Apr 2020 09:49:34 +0200
Message-ID: <20200414074934.urvzzgpi2a36jdf2@ltop.local>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
 <20200413161605.95900-16-luc.vanoostenryck@gmail.com>
 <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
 <20200413185452.pgj75pj5g7a42kik@ltop.local>
 <CAHk-=wjMSeVVQHZ23=HJ3V-yYPooeuHNHmZtexUVRKg_e5VMXA@mail.gmail.com>
 <CAHk-=whNLSTtSsmMD5a6D3s_LtjEYwZPWOSvUdz4mCd5kFO26Q@mail.gmail.com>
 <20200413233900.t7fczyyqrees5gwr@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406749AbgDNHtk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Apr 2020 03:49:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232ECC0A3BDC
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 00:49:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o81so6337977wmo.2
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 00:49:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200413233900.t7fczyyqrees5gwr@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Apr 14, 2020 at 01:39:00AM +0200, Luc Van Oostenryck wrote:
> 
> I like the idea. I just gave it a very quick test with sparse's
> "make check" (it covers a lot of simple but corner/dirty cases that
> the kernel may/should not have). It seemed to pass all the tests but
> the ones using __label__. For exemple, things like this complain:
> 	{
> 		__label__ l;
> 
> 	l:
> 		goto l;
> 	}
> 
> I'll look more at it tommorow as it's a bit late here. I just fear
> that __label__ will spoil things here or at least complicate them.

The problem is that now normal labels use the new label_scope
but the ones declared with __label__ use block_scope and these
2 scopes are kinda in a different namespace of scope.
It's easy to make it work here but the problem would remain
when extra block levels are present, like in:
	{
		__label__ l;
		{
		l:
			goto l;
		}
		goto l;
	}

It's surely salvageable in some ways but I'm not sure it's worth
the troubles.

-- Luc
