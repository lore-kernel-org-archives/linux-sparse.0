From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Wed, 15 Apr 2020 01:09:08 +0200
Message-ID: <20200414230908.kb44bx5fgu3hzq7r@ltop.local>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
 <20200413161605.95900-16-luc.vanoostenryck@gmail.com>
 <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
 <20200413185452.pgj75pj5g7a42kik@ltop.local>
 <CAHk-=wjMSeVVQHZ23=HJ3V-yYPooeuHNHmZtexUVRKg_e5VMXA@mail.gmail.com>
 <CAHk-=whNLSTtSsmMD5a6D3s_LtjEYwZPWOSvUdz4mCd5kFO26Q@mail.gmail.com>
 <20200413233900.t7fczyyqrees5gwr@ltop.local>
 <20200414074934.urvzzgpi2a36jdf2@ltop.local>
 <CAHk-=wiahqumRaQkkcQ_kFhknA9z==DCWNKK-j0GRJH7GUtPEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634356AbgDNXJM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Apr 2020 19:09:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7BEC061A0C
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 16:09:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so16564667wrm.13
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 16:09:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wiahqumRaQkkcQ_kFhknA9z==DCWNKK-j0GRJH7GUtPEw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Apr 14, 2020 at 11:19:32AM -0700, Linus Torvalds wrote:
> On Tue, Apr 14, 2020 at 12:49 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > The problem is that now normal labels use the new label_scope
> > but the ones declared with __label__ use block_scope and these
> > 2 scopes are kinda in a different namespace of scope.
> 
> Oh, I forgot about the special __label__ thing that actually declares labels.
> 
> That one has an interesting behavior, in that the _lifetime_ of the
> symbol is the block scope, but the *use* of the symbol must remain in
> label scope.
> 
> The most obvious fix is probably something like the appended: make the
> 'sym->scope' remain the lifetime scope, but then attach a "must be
> used in this scope' thing to any NS_LABEL case.
> 
> That fairly clearly separates the two issues.

Yes, I see the principle but ... it doesn't work yet for __label__ 
and the more I think about it, the more I think it can't work.
The problem is that the block scopes and the label scopes are
never comparable. At the syntax level the label scope is a subset
of the block levels, less fine grained but for sparse 'struct scope'
they are never the same, even for the same { }.
So, in your patch (with things removed for simplicity):

diff --git a/parse.c b/parse.c
index 8e238f59..b6109516 100644
--- a/parse.c
+++ b/parse.c
@@ -2541,13 +2542,14 @@ static struct token *statement(struct token *token, struct statement **tree)
-			if (s->scope != label_scope) {
-				sparse_error(stmt->pos, "label '%s' used outside label expression", show_ident(s->ident));
+			if (s->scope != s->declared_scope) {

This comparison can never succeed for labels declared with __label__
because s->scope is a block scope and s->declared_scope a label one.

I'm sure it's fixeable in some way and problably it's just me
having a kind of 'mental blocage' but I don't see how the
normal scoping with lookup_symbol() can be really useful for
labels without losing the conceptual simplicity or without going
to something like my previous solution.

-- Luc
