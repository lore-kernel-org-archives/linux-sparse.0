From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Small improvement to output from show_instruction()
Date: Sun, 19 Mar 2017 13:16:46 +0000
Message-ID: <CACXZuxchDG8VnvN5cY=TXwcRe46DDpLx8Hh5eRx6KGq91oLn_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:36504 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdCSNRk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 09:17:40 -0400
Received: by mail-it0-f47.google.com with SMTP id w124so64292535itb.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 06:16:47 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi

To aid understanding and for debugging it is useful if the instruction
type is indicated when the type is not an integer value. I suggest
following small change to show_instruction():

 if (opcode < ARRAY_SIZE(opcodes)) {
  const char *op = opcodes[opcode];
  if (!op)
   buf += sprintf(buf, "opcode:%d", opcode);
  else
   buf += sprintf(buf, "%s", op);
  if (insn->type && is_float_type(insn->type))
   buf += sprintf(buf, ".f%d", insn->size);
  else if (insn->size)
   buf += sprintf(buf, ".%d", insn->size);
  if (insn->type) {
   if (is_ptr_type(insn->type))
    buf += sprintf(buf, "*");
  }
  memset(buf, ' ', 20);
  buf++;
 }

For example, the output for following:

extern int printf(const char *, ...);
int main(void)
{
    printf("%f\n", (double)-1);
    return 0;
}

is shown as:

main:
.L0:
        <entry-point>
        symaddr.64* %r1 <- <anon symbol:0000024A51894818>
        push.64*    %r1
        push.f64    $-1
        call.32     %r2 <- printf
        ret.32      $0


Thanks and Regards
Dibyendu
