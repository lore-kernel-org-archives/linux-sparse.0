From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 03:53:12 -0700
Message-ID: <CAGXu5jLzfuEnWpJFL1Caq94nKbPps-QTaYGpge2CfZWj1Zzf9g@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com> <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ted Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreykn>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 2:41 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, Oct 22, 2018 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> We need to make sure the static analyzers are happy with either
>> method. Additionally, when was -Wimplicit-fallthrough added to GCC? If
>> it was added _before_ the attribute, we need to continue using the
>> comment style otherwise we lose coverage even with gcc itself.
>> Additionally, does Clang support this attribute (it supports
>> -Wimplicit-fallthrough).
>
> Please take a look at the rationale (also more details at the linked thread):
>
>   * gcc 7.1 added -Wimplicit-fallthrough at the same time as the
> attribute and the comment parsing.

Ah, perfect. I missed this. :)

>   * clang does *not* support the attribute in C.

Well that's not good. :)

-Kees

-- 
Kees Cook
Pixel Security
