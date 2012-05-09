From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Wed, 9 May 2012 02:18:56 -0700
Message-ID: <CANeU7QkLrr1p8-Bofx9fnZ82BA2pc7sOxSOa-zim5NhWHXTNQA@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
	<CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
	<4FA38635.5060300@gaisler.com>
	<CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
	<4FA3B14A.3070609@gaisler.com>
	<CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com>
	<4FA44E3D.6020504@gmail.com>
	<CANeU7QmzTDarO9xD7NiRsaSasQnVQug6LFCCp9ud0vuBcekS8Q@mail.gmail.com>
	<4FA4EAD6.1040206@gmail.com>
	<CANeU7QnNemo=iyx3+VJBgEzf4kOacxOx9JTsbu5Of46+3NkAJA@mail.gmail.com>
	<CAEjhO7JqWNwGzEYX+xr2gvuCTcnNPovNgk3X1q69E5_CMPnSTw@mail.gmail.com>
	<CANeU7Qn7vUzLQAF6JGRECro_pPDnL7MCswkrNACe1wohLHZu7g@mail.gmail.com>
	<CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com>
	<4FA5B9E8.7010208@gmail.com>
	<CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com>
	<4FA767BD.8060703@gaisler.com>
	<CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com>
	<4FA8BF7D.60606@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58379 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab2EIJS6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 May 2012 05:18:58 -0400
Received: by yhmm54 with SMTP id m54so35943yhm.19
        for <linux-sparse@vger.kernel.org>; Wed, 09 May 2012 02:18:57 -0700 (PDT)
In-Reply-To: <4FA8BF7D.60606@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Konrad Eisele <eiselekd@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, May 7, 2012 at 11:38 PM, Konrad Eisele <konrad@gaisler.com> wrote:
>
> Yea, I think it is better that way. You should implement it yourself first,
> it kind of takes too long otherwise :-). Still I'm kind of
> curious how you can trace macro expansion with just 1 callback
> but I'll like to be surprised.

OK, there is the initial version of the preprocessor hook.
I create an branch "unclean-preprocess-hook" for review.

http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=shortlog;h=refs/heads/unclean-preprocess-hook

I end up use more than one call back, but it is still better that 6.
I also think that is easier for the caller to use. because it receive the
the before and after at the same time.


struct preprocess_hook {
	void (*expand_macro)(struct token *macro, struct symbol *sym,
			     struct token **replace, struct token **replace_tail);
	void (*expand_arg)(struct token *macro, struct symbol *sym, int arg,
			   struct token *orig, struct token *expanded);
};

The demo program expand your example macro with the following
results:

<beginning of 't.c'>
#define D0(d0a0,d0a1) 1 D1(d0a0) 2 D2(d0a1) 3
#define D1(d1a0) 4 d1a0 5
#define D2(d2a0) 6 d2a0 7
#define D3(d3a0) 8 d3a0 9
D0(D3(10),11)<end of 't.c'>
arg0 in D3 :10 -> 10
macro D3 inside D0
expand result: 8 10 9 <untaint: D3>
arg0 in D0 :D3(10) -> 8 10 9
arg1 in D0 :11 -> 11
macro D0 inside <noident>
expand result: 1 D1(8 10 9) 2 D2(11) 3 <untaint: D0>
arg0 in D1 :8 10 9 -> 8 10 9
macro D1 inside D0
expand result: 4 8 10 9 5 <untaint: D1>
arg0 in D2 :11 -> 11
macro D2 inside D0
expand result: 6 11 7 <untaint: D2>
After preprocessing
1 4 8 10 9 5 2 6 11 7 3

A few things. I don't think you need to manipulate the define for empty
body macro any more. You should be able to find out the macro expand
to empty in the hook.

I still haven't fully understand why you need the empty token type. However
there is the untaint token which mark the end of the a macro expand. You
might able to use that as well.

This branch needs cleanup before merge to the upstream.
Please let me know what I miss.

Chris
