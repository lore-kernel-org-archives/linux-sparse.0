From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] add support for __int128
Date: Tue, 7 Feb 2017 15:40:30 +0100
Message-ID: <20170207144027.jkhkaxlphbybcsrn@macbook.local>
References: <20161209230311.36024-1-luc.vanoostenryck@gmail.com>
 <20161209230311.36024-3-luc.vanoostenryck@gmail.com>
 <CANeU7Qk88LOkmwa3KFSawO+HH=tJyEQi-rOKxkofdDDb-3xb+w@mail.gmail.com>
 <CAMHZB6Hc9qwOve85K7Ji27eEL-dK90fDGebv_U3MgGmF58WFgQ@mail.gmail.com>
 <CANeU7QnmjMr30T7SgRMTi9v_+XhKkexhm0=nbHvnyr7q_cbdiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36532 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbdBGOkd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 09:40:33 -0500
Received: by mail-wr0-f193.google.com with SMTP id k90so5766556wrc.3
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 06:40:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnmjMr30T7SgRMTi9v_+XhKkexhm0=nbHvnyr7q_cbdiQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 07, 2017 at 11:05:19AM +0800, Christopher Li wrote:
> On Tue, Feb 7, 2017 at 10:49 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >>> @@ -1496,6 +1504,8 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
> >>>                         }
> >>>                         seen |= s->op->set;
> >>>                         class += s->op->class;
> >>> +                       if (s->op->set & Set_Int128)
> >>> +                               size = 2;
> >>>                         if (s->op->type & KW_SHORT) {
> >>>                                 size = -1;
> >>>                         } else if (s->op->type & KW_LONG && size++) {
> >>
> >> This patch is already applied in sparse-next.
> >> But I have a question regarding the "size = 2;" Is the number 2 a magic
> >> number?
> >
> > Not really magic but certainly not obvious:
> > * 'size' acts here as a sort of modifiers for interger
> > * plain integer, 'int' thus, are set to 'size = 0'
> > * then if 'short' is encountered, it's set to 'size = -1'
> > * each 'long' increment size by 1
> > * so int = 0, long = 1, long long = 2 & long long long = 3
> > * here __int128 is in fact 'long long long' so should ends to 3
> >   but the code contained a 'size++' which explain the 'size = 2'
> >   I had to had to support this type.
> >
> > To be honest I don't like much what is done with this 'size' but
> > it works and I always try to make the smallest change in the
> > pre-existing code.
> >
> 
> Adding the sparse mailing list.
> 
> Thanks for the explain regarding the size. So the size is actually the
> how many extra int in terms of size.
> 
> In that case, maybe we can add define/enum SIZE_128_BIT as 2,
> SIZE_SHORT as -1 etc together with your comment.

I think it would be misleading because:
* here 'size' is not directly related to the size of the integer
  (in the sizeof() sense) but is very close to the notion of 'rank'
  as used in the C standard
* __int128 is essentially 'long long long int' and as such we should
  set SIZE_128_BIT as 3 and not as 2 but here we have to *initialize*
  it to the preceding rank, 2, as the next run of the loop will
  increment it to the right value, 3.
I tried to do it in a more clear/direct way but as I had then to
duplicate some code I choose to do it with the existing code & logic.

If you wish, I'll look if I can make things a bit clearer or maybe
just adding an appropriate comment.

Luc
