From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v5] sparse: add support for _Static_assert
Date: Sun, 7 May 2017 13:34:13 -0400
Message-ID: <CANeU7Qn+Wzb21p2oWWWwr_tmhr9tc5YrwaEQHTFR08woQwHjkg@mail.gmail.com>
References: <20170504160038.5328-1-lrichard@redhat.com> <CANeU7Q=YnmjjRx5DQqg75o+rXYuyTR7L1tBOzjrBK5XOp3UuJw@mail.gmail.com>
 <20170506231128.h65gxchj3dbaxfmp@desk.local> <CANeU7QnoXnsY-dMC+Rcm4YmgfzjP9F4OoKfJ7FGnbmSctmLR5w@mail.gmail.com>
 <CAMHZB6E3z2mzA_PM_fQZ9o=gBPFb8i17G=PpdfNAOvicE_c9_A@mail.gmail.com> <1193496378.5690229.1494172668762.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33749 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755438AbdEGWx0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 7 May 2017 18:53:26 -0400
Received: by mail-io0-f176.google.com with SMTP id p24so40806951ioi.0
        for <linux-sparse@vger.kernel.org>; Sun, 07 May 2017 15:53:21 -0700 (PDT)
In-Reply-To: <1193496378.5690229.1494172668762.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, May 7, 2017 at 11:57 AM, Lance Richardson <lrichard@redhat.com> wro=
te:
>
> Hi Chris and Luc,
>
> Thank you very much for your feedback and your patience with this series.
>
> I think if the standard allows mixing static assertions with code, sparse=
 should
> also allow it (as both gcc and clang do).
>
> At least gcc does abide by the "static assertions are declarations" idea,=
 e.g.:
>
>     $ gcc -c -Wdeclaration-after-statement moo.c
>     moo.c: In function =E2=80=98foo=E2=80=99:
>     moo.c:11:2: warning: ISO C90 forbids mixed declarations and code [-Wd=
eclaration-after-statement]
>       _Static_assert(1, "");
>       ^~~~~~~~~~~~~~

OK. Luc and you have a good point there. So that warning is too strong.

In your V5 patch.

@@ -2436,11 +2483,14 @@ static struct token * statement_list(struct
token *token, struct statement_list
  }
  stmt =3D alloc_statement(token->pos, STMT_DECLARATION);
  token =3D external_declaration(token, &stmt->declaration);
+ add_statement(list, stmt);
+ } else if (match_static_assert(token)) {
+ token =3D parse_static_assert(token, NULL);
  } else {
  seen_statement =3D Wdeclarationafterstatement;
  token =3D statement(token, &stmt);
+ add_statement(list, stmt);
  }
- add_statement(list, stmt);
  }
  return token;
 }

We don't need to relocate add_statment() into two places. We can add a
"continue"
after the static_assert() parsing.

> It doesn't appear to be possible to do a similar experiment with clang, i=
n that
> case the "ISO C90 forbids mixed declarations and code" warning is only em=
itted
> with "-pedantic C90" or "-pedantic C89", and another warning is produced =
if
> _Static_assert() is used with those options:
>
>    warning: _Static_assert is a C11-specific feature [-Wc11-extensions]
>
> I would be happy to respin, taking the responses to the v5 patch as feedb=
ack.

That would be great. Looking forward to it. While you are there, can you ma=
ke
it apply to master or sparse-next? I have update the master recently the V5
does not apply clean on master any more. It is trivial to fix though.

Chris
