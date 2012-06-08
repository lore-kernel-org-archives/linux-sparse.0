From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC/PATCH] sparse, llvm: Fix string globals access
Date: Fri, 08 Jun 2012 14:13:54 -0400
Message-ID: <4FD240E2.6040003@garzik.org>
References: <1339160327-8534-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64068 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400Ab2FHSN7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 14:13:59 -0400
Received: by yhmm54 with SMTP id m54so1493146yhm.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 11:13:58 -0700 (PDT)
In-Reply-To: <1339160327-8534-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On 06/08/2012 08:58 AM, Pekka Enberg wrote:
> This patch attempts to fix code generation for global string access:
>
>    static char *foo = "Foo !\n";
>
>    extern int puts(const char *s);
>
>    int main(int argc, char *argv[])
>    {
>            puts(foo);
>
>            return 0;
>    }
>
> Unfortunately the generated executable SIGSEGVs:
>
>    [penberg@tux sparse]$ ./sparsec foo.c&&  ./a.out
>    Segmentation fault
>
> Looking at the IR, Sparse/LLVM generates this:
>
>    [penberg@tux sparse]$ ./sparse-llvm foo.c | llvm-dis
>    ; ModuleID = '<stdin>'
>
>    @"<noident>" = private global [7 x i8] c"Foo !\0A\00"
>    @foo = private global [7 x i8]* @"<noident>"
>
>    define i32 @main(i32, i8**) {
>    L0:
>      %load_target = load i64* bitcast ([7 x i8]* @"<noident>" to i64*)
>      %2 = call i32 @puts(i64 %load_target)
>      ret i32 0
>    }
>
>    declare i32 @puts(i64)
>
> whereas Clang generates the following:
>
>    @.str = private unnamed_addr constant [7 x i8] c"Foo !\0A\00", align 1
>
>    define i32 @main(i32 %argc, i8** nocapture %argv) nounwind uwtable {
>      %1 = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0)) nounwind
>      ret i32 0
>    }
>
>    declare i32 @puts(i8* nocapture) nounwind
>
> I'm not sure what the LLVM backend can do here. Sparse linearizes the code to
> this which is why LLVM backend does the casting:
>
>    [penberg@tux sparse]$ ./test-linearize foo.c
>    main:
>    .L0x7f341f6f1010:
>            <entry-point>
>            load.64     %r1<- 0[foo]
>            call.32     %r2<- puts, %r1
>            ret.32      $0
>
> Comments?
>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Christopher Li<sparse@chrisli.org>
> Cc: Jeff Garzik<jgarzik@redhat.com>
> NOT-Signed-off-by: Pekka Enberg<penberg@kernel.org>
> ---
>   sparse-llvm.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)

ACK



