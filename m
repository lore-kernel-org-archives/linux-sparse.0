From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/5] Fix some "enum value 'SYM_...' not handled in switch"
 warnings
Date: Tue, 21 Jul 2009 22:15:49 +0100
Message-ID: <4A663005.5090009@ramsay1.demon.co.uk>
References: <4A62338A.1060600@ramsay1.demon.co.uk> <20090719140125.GA25417@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:63055 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756157AbZGUV4f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Jul 2009 17:56:35 -0400
In-Reply-To: <20090719140125.GA25417@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Josh Triplett wrote:
> On Sat, Jul 18, 2009 at 09:41:46PM +0100, Ramsay Jones wrote:
>> These warnings were issued by gcc v3.4.4, but not by gcc v4.1.2.
>> So I guess gcc probably found these warnings to be too noisy ...
> [...]
>> --- a/parse.c
>> +++ b/parse.c
>> @@ -2616,6 +2616,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>>  			case SYM_ENUM:
>>  			case SYM_RESTRICT:
>>  				base_type->ident = ident;
>> +			default:
>> +				break;
>>  			}
> 
> I don't think you want to add defaults like this just to avoid warnings.
> Warnings like that can help when adding a new item to an enum, to find
> the places where you need to extend the code to hand the new item.  And
> since current GCC doesn't even issue the warning by default, it seems
> even more unnecessary to add that default case.
> 

OK...

So, if I understand your argument, in order to make the best use of these
warnings, then the correct change would look like the diff given below,
and (for more up-to-date gcc) add -Wswitch-enum to CFLAGS (at least
occasionally).

Yes?

[if no, then I obviously don't understand ;-)]

Hmm, I have another idea; a new patch is brewing!

ATB,
Ramsay Jones

-->8--
diff --git a/parse.c b/parse.c
index e5ad867..afe39c3 100644
--- a/parse.c
+++ b/parse.c
@@ -2616,6 +2616,23 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			case SYM_ENUM:
 			case SYM_RESTRICT:
 				base_type->ident = ident;
+				break;
+			case SYM_UNINITIALIZED:
+			case SYM_PREPROCESSOR:
+			case SYM_BASETYPE:
+			case SYM_NODE:
+			case SYM_PTR:
+			case SYM_FN:
+			case SYM_ARRAY:
+			case SYM_TYPEDEF:
+			case SYM_TYPEOF:
+			case SYM_MEMBER:
+			case SYM_BITFIELD:
+			case SYM_LABEL:
+			case SYM_FOULED:
+			case SYM_KEYWORD:
+			case SYM_BAD:
+				break;
 			}
 		}
 	} else if (base_type && base_type->type == SYM_FN) {
-->8--



