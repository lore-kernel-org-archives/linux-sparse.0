From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Sun, 6 May 2012 11:34:34 -0700
Message-ID: <CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42542 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab2EFSef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 6 May 2012 14:34:35 -0400
Received: by yenm10 with SMTP id m10so3241305yen.19
        for <linux-sparse@vger.kernel.org>; Sun, 06 May 2012 11:34:34 -0700 (PDT)
In-Reply-To: <4FA5B9E8.7010208@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, May 5, 2012 at 4:38 PM, Konrad Eisele <eiselekd@gmail.com> wrot=
e:
>
> I appended a diff for review. Is this kind of interface ok?
> This is kind of not a patch to apply, rather I want to avoid to put
> effort in it and you telling me later I am too intrusive...:). So
> can you give a ok or comment...
>
> Interface so far:
> struct preprocess_hook {
> =A0 =A0 =A0 =A0def =A0 =A0 =A0: called when #define is processed

Why do you need #define hooks? The macro symbol
should have pos and macro body already.

> =A0 =A0 =A0 =A0args_beg : called before argument expasnion
> =A0 =A0 =A0 =A0args_end : called after argument expasnion
> =A0 =A0 =A0 =A0body_beg : called before body expansion
> =A0 =A0 =A0 =A0body_end : called after body expansion

I am wondering why is do you need 4 call backs for macro
expand instead of just one like the patch I post previously.
That macro expand give you the name of the macro need to
be expand and the replacement list.  My guess is that you
want the end position of the macro before expand. That
can be add to the macro expand hook. Will that be sufficient?


> =A0 =A0 =A0 =A0post =A0 =A0 : called after preprocess

I don't think the post call back is needed. You can call
the preprocessor directly. It will return when it complete.
Then you can do your post work. You can invoke the parser
separately.  The sparse wrapper function does it all in
one function but that did not stop you it step by step
if you wants to.


> All of there I found are needed. There might be more to be added...
>
> I also introduce a tokentype TOKEN_M_EMPTY so that I can track
> empty expansion. To filter these out again I add the post hook.

What purpose does the token_m_empty if you filter those token later?
Rember where in the stream there is an invisible macro?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
