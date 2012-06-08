From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RFC/PATCH] sparse, llvm: Fix string globals access
Date: Fri, 8 Jun 2012 23:39:51 +0300
Message-ID: <CAOJsxLH9N84YwLrHQXn+R1r4cOd7DUuM2SpFq828mSV6WmHjqg@mail.gmail.com>
References: <1339160327-8534-1-git-send-email-penberg@kernel.org>
	<4FD240E2.6040003@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38049 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab2FHUjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 16:39:51 -0400
Received: by vbbff1 with SMTP id ff1so1374890vbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 13:39:51 -0700 (PDT)
In-Reply-To: <4FD240E2.6040003@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Xi Wang <xi.wang@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jun 8, 2012 at 9:13 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 06/08/2012 08:58 AM, Pekka Enberg wrote:
>>
>> This patch attempts to fix code generation for global string access:
>>
>> =A0 static char *foo =3D "Foo !\n";
>>
>> =A0 extern int puts(const char *s);
>>
>> =A0 int main(int argc, char *argv[])
>> =A0 {
>> =A0 =A0 =A0 =A0 =A0 puts(foo);
>>
>> =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 }
>>
>> Unfortunately the generated executable SIGSEGVs:
>>
>> =A0 [penberg@tux sparse]$ ./sparsec foo.c&& =A0./a.out
>>
>> =A0 Segmentation fault
>>
>> Looking at the IR, Sparse/LLVM generates this:
>>
>> =A0 [penberg@tux sparse]$ ./sparse-llvm foo.c | llvm-dis
>> =A0 ; ModuleID =3D '<stdin>'
>>
>> =A0 @"<noident>" =3D private global [7 x i8] c"Foo !\0A\00"
>> =A0 @foo =3D private global [7 x i8]* @"<noident>"
>>
>> =A0 define i32 @main(i32, i8**) {
>> =A0 L0:
>> =A0 =A0 %load_target =3D load i64* bitcast ([7 x i8]* @"<noident>" t=
o i64*)
>> =A0 =A0 %2 =3D call i32 @puts(i64 %load_target)
>> =A0 =A0 ret i32 0
>> =A0 }
>>
>> =A0 declare i32 @puts(i64)
>>
>> whereas Clang generates the following:
>>
>> =A0 @.str =3D private unnamed_addr constant [7 x i8] c"Foo !\0A\00",=
 align 1
>>
>> =A0 define i32 @main(i32 %argc, i8** nocapture %argv) nounwind uwtab=
le {
>> =A0 =A0 %1 =3D tail call i32 @puts(i8* getelementptr inbounds ([7 x =
i8]* @.str,
>> i64 0, i64 0)) nounwind
>> =A0 =A0 ret i32 0
>> =A0 }
>>
>> =A0 declare i32 @puts(i8* nocapture) nounwind
>>
>> I'm not sure what the LLVM backend can do here. Sparse linearizes th=
e code
>> to
>> this which is why LLVM backend does the casting:
>>
>> =A0 [penberg@tux sparse]$ ./test-linearize foo.c
>> =A0 main:
>> =A0 .L0x7f341f6f1010:
>> =A0 =A0 =A0 =A0 =A0 <entry-point>
>> =A0 =A0 =A0 =A0 =A0 load.64 =A0 =A0 %r1<- 0[foo]
>> =A0 =A0 =A0 =A0 =A0 call.32 =A0 =A0 %r2<- puts, %r1
>> =A0 =A0 =A0 =A0 =A0 ret.32 =A0 =A0 =A0$0
>>
>> Comments?
>>
>> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> Cc: Christopher Li<sparse@chrisli.org>
>> Cc: Jeff Garzik<jgarzik@redhat.com>
>> NOT-Signed-off-by: Pekka Enberg<penberg@kernel.org>
>> ---
>> =A0sparse-llvm.c | =A0 =A08 +++++++-
>> =A01 files changed, 7 insertions(+), 1 deletions(-)
>
> ACK

Xi, so I guess your current work on linearize.c might fix the SIGSEGV
I'm seeing?
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
