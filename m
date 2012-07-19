From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: sparse-llvm segfaults when passing a struct pointer
Date: Thu, 19 Jul 2012 15:17:25 +0200
Message-ID: <20120719131725.GA2836@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:43651 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750964Ab2GSNR2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Jul 2012 09:17:28 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

compiling a little real-world program with sparse-llvm, it segfaulted.
Using a tool called "delta"[1] and some bash scripting, I managed to
reduce the code to this test case:

    //struct foo {int a;};
    //struct foo;
    extern struct foo *foop;
    extern void func(struct foo *f);
    int main(int argc, char **argv) {
    	func(foop);
    }

(Uncommenting the commented lines doesn't change the crashing)

gdb gives me this backtrace:

    (gdb) bt
    #0  0x080b86c1 in LLVMBuildPtrToInt ()
    #1  0x080530fd in output_op_load (insn=3D0xb742512c, fn=3D0xbf85624=
c) at sparse-llvm.c:595
    #2  output_insn (insn=3D0xb742512c, fn=3D0xbf85624c) at sparse-llvm=
=2Ec:1008
    #3  output_bb (generation=3D7, fn=3D0xbf85624c, bb=3D<optimized out=
>) at sparse-llvm.c:1096
    #4  output_fn (module=3D0xb7738f0c, module@entry=3D0x8ccc750, ep=3D=
<error reading variable: Unhandled dwarf expression opcode 0xfa>,
        ep=3D<error reading variable: Unhandled dwarf expression opcode=
 0xfa>) at sparse-llvm.c:1166
    #5  0x080507ec in compile (list=3D0xb773858c, module=3D0x8ccc750) a=
t sparse-llvm.c:1227
    #6  main (argc=3D2, argv=3D0xbf856684) at sparse-llvm.c:1246

I'm using llvm version 3.0 (package version 1:3.0-14) from Debian and
sparse v0.4.4-100-g063236f (the most recent commit in git).

Thanks,
Jonathan Neusch=C3=A4fer


[1] http://delta.tigris.org/

PS: I've also found sparse-llvm to crash if the source file contains
only the following (obviously incorrect) line, but I considered that
lower priority, since it is already incorrect code:

	static void out_byte(FILE *out, unsigned char byte) {
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
