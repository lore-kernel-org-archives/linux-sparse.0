From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Subject: Re: [PATCH][RFC] handle -I and -include combination
Date: Wed, 27 Jun 2012 13:55:02 -0400
Message-ID: <CAHGf_=oozZQZtyQow1GocS-=o8EiXctCP1HBa7Y7kMgCG58x6A@mail.gmail.com>
References: <1340023258-7069-1-git-send-email-kosaki.motohiro@gmail.com> <CANeU7Qm=0cCqHRJpDxeRK=QmqpJRyXu9wo1tKzCQqSxsQ_dLqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:37039 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab2F0RzX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2012 13:55:23 -0400
Received: by ghrr11 with SMTP id r11so1168018ghr.19
        for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2012 10:55:22 -0700 (PDT)
In-Reply-To: <CANeU7Qm=0cCqHRJpDxeRK=QmqpJRyXu9wo1tKzCQqSxsQ_dLqQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Hi,

Thanks for reviewing.

On Tue, Jun 26, 2012 at 3:52 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> On Mon, Jun 18, 2012 at 5:40 AM, =A0<kosaki.motohiro@gmail.com> wrote=
:
>> From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
>>
>> Currently, "-include" behavior is far different between sparse
>> and gcc. gcc can compile following testcase. but sparse can't.
>>
>> This patch fixes it.
>>
>
> Thanks for the patch. The patch has some small problem though:
> There are some other user of the cmdline_include array.
> Remove it will disable those options.

If I understand correctly, cmdline_include is only used from -include
and -imacro. and, -imacro is also needed to respect -I. Am I missing
something?

I'm now seeing  git://git.kernel.org/pub/scm/devel/sparse/sparse.git.


> Also the include order of the header file is now reversed:
>
> $ =A0gcc -include a.h -include b.h =A0foo.c
> will include a.h then b.h.
> Your patch will include b.h then a.h.

Sorry, I can't reproduce this.

a.h
----------------
#ifdef FOO
#error a.h
#endif
#define FOO 'a'

b.h
----------------
#ifdef FOO
#error b.h
#endif
#define FOO 'b'

main.c
-------------
int main(void)
{
	printf("foo =3D %d\n", FOO);
	return 0;
}

result
---------------------
b.h:2:2: error: b.h

> Granted, the "isystem" has the same bug here too.
>
> Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
