From: Christopher Li <sparse@chrisli.org>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Thu, 19 Mar 2009 16:11:41 -0700
Message-ID: <70318cbf0903191611i4ec1f5e5sa97ba53db3a7478c@mail.gmail.com>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com>
	 <20090319144622.GA28946@ZenIV.linux.org.uk>
	 <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com>
	 <20090319191431.GD28946@ZenIV.linux.org.uk>
	 <70318cbf0903191304k1fefe9afkb4be21550d8f9abe@mail.gmail.com>
	 <20090319215250.GF28946@ZenIV.linux.org.uk>
	 <20090319220906.GG28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:13271 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbZCSXLn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 19:11:43 -0400
Received: by rv-out-0506.google.com with SMTP id f9so791688rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2009 16:11:42 -0700 (PDT)
In-Reply-To: <20090319220906.GG28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hannes Eder <hannes@hanneseder.net>, linux-sparse@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

Thanks Al,

I will apply it later tonight.

If no one beats to me, I will try to add the warning for using preproce=
ssor
directive inside macro expansion. It should be a better error message
than the current one.

Chris

On Thu, Mar 19, 2009 at 3:09 PM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Thu, Mar 19, 2009 at 09:52:50PM +0000, Al Viro wrote:
>> On Thu, Mar 19, 2009 at 01:04:20PM -0700, Christopher Li wrote:
>>
>> > We should stop the segfault though. I take a look at it. It seems =
that
>> > there is a SYM_NODE with base_type is NULL. I guess in some of
>> > the error path we result in an invalid AST three.
>>
>> We are getting some mess with K&R declarations. =A0Which is bloody l=
ikely
>> to be my fault; will check.
>
> Yeah... =A0It's an old b0rken handling of calls for K&R + changes tha=
t exposed
> that even worse.
>
> Status quo is restored by the patch below, but it's a stopgap - e.g.
> void f();
> void g(void)
> {
> =A0 =A0 =A0 =A0f(0, 0);
> }
> will warn about extra arguments as if we had void f(void); as sparse =
had
> been doing all along. =A0B0rken.
>
> Testcase for the segfault is
> void f(x, y);
> void g(void)
> {
> =A0 =A0 =A0 =A0f(0, 0);
> }
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/parse.c b/parse.c
> index b9b96ba..87f6264 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -2323,6 +2323,7 @@ static struct token *identifier_list(struct tok=
en *token, struct symbol *fn)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sym->ident =3D token->ident;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0token =3D token->next;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sym->endpos =3D token->pos;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sym->ctype.base_type =3D &incomplete_ct=
ype;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_symbol(list, sym);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!match_op(token, ',') ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0token_type(token->next) !=3D T=
OKEN_IDENT ||
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
